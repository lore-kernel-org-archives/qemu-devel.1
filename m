Received: from eggs.gnu.org ([209.51.188.92]:53298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gkRVM-00014K-Da
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gkRVI-0005Ws-GW
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:36:02 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1gkRVF-0005ET-CD
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:35:58 -0500
Received: by mail-oi1-x243.google.com with SMTP id y23so8614577oia.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 02:35:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1547807155-4526-2-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547807155-4526-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1547807155-4526-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 18 Jan 2019 11:35:54 +0100
Message-ID: <CAL1e-=hokKEVkzCf63UYuL67wfEnETgK9ZuZ=R8miY7SDHNsFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] contrib: gitdm: Update domain-map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>

On Friday, January 18, 2019, Aleksandar Markovic <
aleksandar.markovic@rt-rk.com> wrote:

> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add Citrix, Huawei, Intel, and Microsoft to domain-map.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  contrib/gitdm/domain-map | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 0ab41ee..9c09285 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -5,10 +5,14 @@
>  #
>
>  amd.com         AMD
> +citrix.com      Citrix
>  greensocs.com   GreenSocs
> +huawei.com      Huawei
>  ibm.com         IBM
> +intel.com       Intel
>  igalia.com      Igalia


Intel should be after Igalia, in alphabethical order, I just noticed.


>  linaro.org      Linaro
> +microsoft.com   Microsoft
>  nokia.com       Nokia
>  oracle.com      Oracle
>  proxmox.com     Proxmox
> --
> 2.7.4
>
>
>
