Received: from eggs.gnu.org ([209.51.188.92]:51845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkALX-0003zE-0G
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gkALW-0008RV-6t
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:16:46 -0500
References: <20190117153338.11820-1-alex.bennee@linaro.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <5258121f-d54b-8b58-f393-7f9140760950@redhat.com>
Date: Thu, 17 Jan 2019 11:08:29 -0500
MIME-Version: 1.0
In-Reply-To: <20190117153338.11820-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts/replay-dump.py: fix utf-8 mangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-trivial@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>



On 1/17/19 10:33 AM, Alex Benn=C3=A9e wrote:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  scripts/replay-dump.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
> index 5ae77c8a92..ee7fda2638 100755
> --- a/scripts/replay-dump.py
> +++ b/scripts/replay-dump.py
> @@ -3,7 +3,7 @@
>  #
>  # Dump the contents of a recorded execution stream
>  #
> -#  Copyright (c) 2017 Alex Benn=C3=83=C2=A9e <alex.bennee@linaro.org>
> +#  Copyright (c) 2017 Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  #
>  # This library is free software; you can redistribute it and/or
>  # modify it under the terms of the GNU Lesser General Public
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>
