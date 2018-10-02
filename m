Received: from eggs.gnu.org ([2001:4830:134:3::10]:34858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7JRy-0007tj-35
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7JQS-0006gq-Jn
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:05:22 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:46293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7JQO-0006dc-Qb
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:05:14 -0400
Received: by mail-oi1-x232.google.com with SMTP id k64-v6so1244226oia.13
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 05:05:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181002042526.9565-1-david@gibson.dropbear.id.au>
References: <20181002042526.9565-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 13:04:49 +0100
Message-ID: <CAFEAcA_VmDRsP-E37i=b57b2Eqra-P332zdoXN_COE3Mf59s+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] libfdt queue 20181002
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On 2 October 2018 at 05:25, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit a2ef4d9e95400cd387ab4ae19a317741e458fb07:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20181001-pull-request' into staging (2018-10-01 15:44:30 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/libfdt-20181002
>
> for you to fetch changes up to 0b001b3094bcf80a5a0c3b7655029a10fb63f661:
>
>   Update dtc/libfdt submodule to v1.4.7 (2018-10-02 13:53:26 +1000)
>
> ----------------------------------------------------------------
> Update dtc submodule to v1.4.7
>
> We have some upcoming things planned for ppc that will require some
> newer libfdt features.  In preparation, update the dtc/libfdt
> submodule to upstreasm version v1.4.7.
>
> ----------------------------------------------------------------
> David Gibson (1):
>       Update dtc/libfdt submodule to v1.4.7
>
>  dtc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Applied, thanks.

-- PMM
