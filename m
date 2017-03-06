Received: from eggs.gnu.org ([2001:4830:134:3::10]:58457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckpDl-0000jl-96
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckpDk-00032d-FM
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:46:25 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckpDk-00032Q-9O
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:46:24 -0500
Received: by mail-wr0-x230.google.com with SMTP id l37so112336214wrc.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 01:46:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2130c1b2-0f81-13f6-a1f8-c0a2e294e3f0@amsat.org>
References: <20170305214857.9510-1-krzk@kernel.org>
	<20170305214857.9510-3-krzk@kernel.org>
	<2130c1b2-0f81-13f6-a1f8-c0a2e294e3f0@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Mar 2017 09:46:02 +0000
Message-ID: <CAFEAcA8DOfstrMiEBLsgf6U6S9uT9ahA1ALrJdmQhcV+7K8Obw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/3] hw/misc/exynos4210_pmu:
 Reorder local variables for readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 6 March 2017 at 04:06, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> your change seems OK but while you are here, 'unsigned' is considered
> harmful since more than a decade.

Considered harmful by who, and why?

thanks
-- PMM
