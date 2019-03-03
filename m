Received: from eggs.gnu.org ([209.51.188.92]:58066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1h0NKc-0007kH-In
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 04:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1h0NDB-00071f-H6
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 04:15:10 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1h0NDB-0006zY-7D
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 04:15:09 -0500
Received: by mail-wm1-x343.google.com with SMTP id a62so1844466wmh.4
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 01:15:09 -0800 (PST)
References: <20190301100310.22345-1-alex.bennee@linaro.org>
	<20190301100310.22345-6-alex.bennee@linaro.org>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <d1067255-8a3c-a9c0-cc93-a9724448d9db@gmail.com>
Date: Sun, 3 Mar 2019 11:15:47 +0200
MIME-Version: 1.0
In-Reply-To: <20190301100310.22345-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 5/5] contrib: gitdm: add a mapping for
 Janus Technologies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org



On 3/1/19 12:03 PM, Alex Bennée wrote:
> Currently this just includes Marcel who is a fairly prolific
> contributor.
>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   contrib/gitdm/group-map-janustech | 5 +++++
>   gitdm.config                      | 1 +
>   2 files changed, 6 insertions(+)
>   create mode 100644 contrib/gitdm/group-map-janustech
>
> diff --git a/contrib/gitdm/group-map-janustech b/contrib/gitdm/group-map-janustech
> new file mode 100644
> index 0000000000..4ae7cc24f2
> --- /dev/null
> +++ b/contrib/gitdm/group-map-janustech
> @@ -0,0 +1,5 @@
> +#
> +# Janus Technologies contributors using non-corporate email
> +#
> +
> +marcel.apfelbaum@gmail.com
> diff --git a/gitdm.config b/gitdm.config
> index 7472d4b8be..c01c219078 100644
> --- a/gitdm.config
> +++ b/gitdm.config
> @@ -36,6 +36,7 @@ GroupMap contrib/gitdm/group-map-wavecomp Wave Computing
>   GroupMap contrib/gitdm/group-map-cadence Cadence Design Systems
>   GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
>   GroupMap contrib/gitdm/group-map-ibm IBM
> +GroupMap contrib/gitdm/group-map-janustech Janus Technologies
>   
>   # Also group together our prolific individual contributors
>   # and those working under academic auspices

Acked-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
