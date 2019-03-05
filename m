Received: from eggs.gnu.org ([209.51.188.92]:47530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1EUT-0002XQ-Hs
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1EUS-0003dQ-RE
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:08:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1EUS-0003bY-Kr
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:08:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so3522219wmj.1
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 10:08:32 -0800 (PST)
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-13-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <88e8b541-6623-7ce0-9672-2077f71000a3@redhat.com>
Date: Tue, 5 Mar 2019 19:08:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190305172139.32662-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 12/12] MAINTAINERS: Add entry for Sphinx
 documentation infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 3/5/19 6:21 PM, Peter Maydell wrote:
> Add a MAINTAINERS entry for Sphinx documentation infrastructure:
> this doesn't cover actual content, only the machinery we use to
> build the docs.

Thanks!

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5040d9dfb12..074ad46d473 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2567,3 +2567,9 @@ GIT submodules
>  M: Daniel P. Berrange <berrange@redhat.com>
>  S: Odd Fixes
>  F: scripts/git-submodule.sh
> +
> +Sphinx documentation configuration and build machinery
> +M: Peter Maydell <peter.maydell@linaro.org>
> +S: Maintained
> +F: docs/conf.py
> +F: docs/*/conf.py
> 
