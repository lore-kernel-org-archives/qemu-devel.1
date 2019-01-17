Received: from eggs.gnu.org ([209.51.188.92]:44444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gkBex-00062t-3I
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gkBew-0004Kb-49
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:40:55 -0500
References: <20190117153338.11820-1-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d24afd45-2f2c-8401-a70b-6e78ceff8dcf@vivier.eu>
Date: Thu, 17 Jan 2019 18:40:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190117153338.11820-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] scripts/replay-dump.py: fix
 utf-8 mangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-trivial@nongnu.org
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 17/01/2019 16:33, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   scripts/replay-dump.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
> index 5ae77c8a92..ee7fda2638 100755
> --- a/scripts/replay-dump.py
> +++ b/scripts/replay-dump.py
> @@ -3,7 +3,7 @@
>   #
>   # Dump the contents of a recorded execution stream
>   #
> -#  Copyright (c) 2017 Alex BennÃ©e <alex.bennee@linaro.org>
> +#  Copyright (c) 2017 Alex Bennée <alex.bennee@linaro.org>
>   #
>   # This library is free software; you can redistribute it and/or
>   # modify it under the terms of the GNU Lesser General Public
> 


Applied to my trivial-patches branch.

Thanks,
Laurent
