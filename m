Received: from eggs.gnu.org ([209.51.188.92]:45502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gkBiN-0000pv-JQ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:44:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gkBiI-0000LG-7I
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:44:24 -0500
References: <20190111155555.8270-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <03f668ac-821b-7179-78e7-ce8c921d3dc0@vivier.eu>
Date: Thu, 17 Jan 2019 18:44:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190111155555.8270-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] contrib/gitdm: Fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 11/01/2019 16:55, Philippe Mathieu-Daudé wrote:
> Typo comes from upstream git://git.lwn.net/gitdm.git.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   contrib/gitdm/filetypes.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
> index 15d6f803b9..165b71b3f9 100644
> --- a/contrib/gitdm/filetypes.txt
> +++ b/contrib/gitdm/filetypes.txt
> @@ -4,7 +4,7 @@
>   # This program is free software; you can redistribute it and/or modify
>   # it under the terms of the GNU General Public License as published by
>   # the Free Software Foundation; either version 2 of the License, or
> -# (at your option  any later version.
> +# (at your option) any later version.
>   #
>   # This program is distributed in the hope that it will be useful,
>   # but WITHOUT ANY WARRANTY; without even the implied warranty of
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
