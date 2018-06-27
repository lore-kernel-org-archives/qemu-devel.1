Received: from eggs.gnu.org ([2001:4830:134:3::10]:44831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fYDl1-0001A3-Lo
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fYDl0-0006AU-Ne
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:57:27 -0400
Date: Wed, 27 Jun 2018 12:57:20 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180627165720.GB17117@flamenco>
References: <20180625160009.17437-1-alex.bennee@linaro.org>
	<20180625160009.17437-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180625160009.17437-2-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 1/5] target/arm: support reading of
 CNT[VCT|FRQ]_EL0 from user-space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Mon, Jun 25, 2018 at 17:00:05 +0100, Alex Bennée wrote:
> Since kernel commit a86bd139f2 (arm64: arch_timer: Enable CNTVCT_EL0
> trap..)

I'd also mention here that this feature became available in v4.12.

Thanks,

		Emilio
