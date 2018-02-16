Received: from eggs.gnu.org ([2001:4830:134:3::10]:40932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emiMg-0000ya-0z
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emiMf-0007or-7K
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:55:58 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:44781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emiMf-0007oZ-0Z
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:55:57 -0500
Received: by mail-ot0-x22f.google.com with SMTP id 79so3069234oth.11
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 07:55:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216100617.25265-1-david@gibson.dropbear.id.au>
References: <20180216100617.25265-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2018 15:55:35 +0000
Message-ID: <CAFEAcA_6W0MtGmL5N6=u6nePc3s3bbwNcwxdNScbs3xpO=h5yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] ppc-for-2.12 queue 20180216
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>, surajjs@au1.ibm.com

On 16 February 2018 at 10:06, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit cc5a0ae03e0d011521ca5b32d3995a299b6b3ad3:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180215-1' into staging (2018-02-15 18:37:46 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180216
>
> for you to fetch changes up to 58d5b22bbd505dc942d137d5d3da89ad9bc16c0a:
>
>   ppc4xx: Add device models found in PPC440 core SoCs (2018-02-16 14:06:07 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-02-16
>
> Highlights of this batch:
>   * Conversion to TranslatorOps (Emilio Cota)
>   * Further bugfixes and cleanups to vcpu id allocation for pseries
>     (Greg Kurz)
>   * Another bugfix for HPT resizing (Daniel Henrique-Barboza)
>   * Macintosh CUDA cleanups (Mark Cave-Ayland)
>   * Further tweaks to Spectre/Meltdown mitigations (Suraj Singh)
>

Applied, thanks.

-- PMM
