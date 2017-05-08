Received: from eggs.gnu.org ([2001:4830:134:3::10]:46236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gk4-0006DO-QA
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gk1-00070s-Mh
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:22:16 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7gk1-00070o-GL
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:22:13 -0400
Received: by mail-wm0-x231.google.com with SMTP id u65so80795837wmu.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 04:22:13 -0700 (PDT)
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-24-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508045715.21770-24-f4bug@amsat.org>
Date: Mon, 08 May 2017 12:22:55 +0100
Message-ID: <87tw4v8ueo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 23/23] MAINTAINERS: self-appoint me as
 reviewer in build/test automation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9251f575d8..c7520b76db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1827,6 +1827,7 @@ Build and test automation
>  -------------------------
>  M: Alex Bennée <alex.bennee@linaro.org>
>  M: Fam Zheng <famz@redhat.com>
> +R: Philippe Mathieu-Daudé <f4bug@amsat.org>
>  L: qemu-devel@nongnu.org
>  S: Maintained
>  F: .travis.yml

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
