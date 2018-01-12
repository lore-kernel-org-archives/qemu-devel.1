Received: from eggs.gnu.org ([2001:4830:134:3::10]:39993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eZyad-0007BE-66
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eZyaY-0000ZL-AB
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:37:43 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:40160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eZyaY-0000Y0-1t
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:37:38 -0500
Received: by mail-wr0-x230.google.com with SMTP id 100so5183143wrb.7
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 04:37:37 -0800 (PST)
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
	<1515756676-3860-36-git-send-email-pbonzini@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1515756676-3860-36-git-send-email-pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:37:35 +0000
Message-ID: <87h8rruub4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 35/52] scripts/qemu-gdb: add simple tcg lock
 status helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>
> --- /dev/null
> +++ b/scripts/qemugdb/tcg.py
> @@ -0,0 +1,46 @@
> +#!/usr/bin/python
> +# -*- coding: utf-8 -*-
> +#
> +# GDB debugging support, TCG status
> +#
> +# Copyright 2016 Linaro Ltd
> +#
> +# Authors:
> +#  Alex Benn=C3=83=C2=A9e <alex.bennee@linaro.org>
<snip>

Hmm some munging occurred somewhere.

--
Alex Benn=C3=A9e
