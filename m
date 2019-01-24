Received: from eggs.gnu.org ([209.51.188.92]:45664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmaZQ-0001bv-Nz
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmaQT-0001RS-PR
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:31:54 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gmaQT-0001QG-I5
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:31:53 -0500
Received: by mail-wr1-x442.google.com with SMTP id r10so5437155wrs.10
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 00:31:53 -0800 (PST)
References: <20190124010023.24397-1-philmd@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190124010023.24397-1-philmd@redhat.com>
Date: Thu, 24 Jan 2019 08:31:50 +0000
Message-ID: <87womuzcax.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] archive-source.sh: Clone the
 submodules locally and add to MAINTAINERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, "Daniel P . Berrange" <berrange@redhat.com>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> A minor change to speed up VM testing: clone submodules locally
> (like we do with the QEMU repository).
> Also add the script to MAINTAINERS.
<snip>

Queued to testing/next, thanks.

--
Alex Benn=C3=A9e
