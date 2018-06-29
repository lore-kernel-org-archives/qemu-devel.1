Received: from eggs.gnu.org ([2001:4830:134:3::10]:56694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYuWy-0001g0-7p
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYuWt-0006sz-Rm
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:37:47 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYuWt-0006pP-Jg
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:37:43 -0400
Received: by mail-wr0-x235.google.com with SMTP id c13-v6so9074879wrq.2
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:37:43 -0700 (PDT)
References: <20180628164643.9668-1-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180628164643.9668-1-f4bug@amsat.org>
Date: Fri, 29 Jun 2018 15:37:41 +0100
Message-ID: <871scpvetm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/8] Docker improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Thomas Huth <huth@tuxfamily.org>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi,
>
Hi,

I've queued the following in my tree.

>   docker: ubuntu: Update the package list before installing new ones
>   docker: ubuntu: Use SDL2
>   docker: Clean the MXE base image
>   docker: Do not run tests in 'intermediate' images

--
Alex Benn=C3=A9e
