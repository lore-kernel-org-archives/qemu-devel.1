Received: from eggs.gnu.org ([2001:4830:134:3::10]:44468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1d72K4-0001dr-9A
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1d72K3-0004gf-Jq
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:12:44 -0400
Date: Sat, 6 May 2017 18:12:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170506161233.dtqh3tfueol7ln6q@kozik-lap>
References: <20170506152414.8704-1-krzk@kernel.org>
	<20170506152414.8704-2-krzk@kernel.org>
	<05f9ba66-784d-0dee-fd0b-48f0f8f15d1d@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <05f9ba66-784d-0dee-fd0b-48f0f8f15d1d@amsat.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/3] hw/arm/exynos: Move RAM
 initialization next boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Sat, May 06, 2017 at 01:05:19PM -0300, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Krzysztof,
>=20
> Please modify RAM -> DRAM in subject/description so there is no confusion
> about also moving the IRAM (which is SoC specific).
>=20
> With this:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Sure, thanks for review.

Best regards,
Krzysztof
