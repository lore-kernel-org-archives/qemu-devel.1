Received: from eggs.gnu.org ([2001:4830:134:3::10]:45953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gj2-0005C5-R5
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7giz-0006nS-O8
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:21:12 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7giz-0006n7-Gq
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:21:09 -0400
Received: by mail-wm0-x234.google.com with SMTP id 142so61162489wma.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 04:21:09 -0700 (PDT)
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-23-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508045715.21770-23-f4bug@amsat.org>
Date: Mon, 08 May 2017 12:21:52 +0100
Message-ID: <87wp9r8ugf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 22/23] MAINTAINERS: add Shippable
 automation platform URL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a1d2b3a4d3..9251f575d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1833,6 +1833,7 @@ F: .travis.yml
>  F: .shippable.yml
>  F: tests/docker/
>  W: https://travis-ci.org/qemu/qemu
> +W: https://app.shippable.com/github/qemu/qemu
>  W: http://patchew.org/QEMU/
>
>  Documentation

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
