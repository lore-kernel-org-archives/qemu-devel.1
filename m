Received: from eggs.gnu.org ([2001:4830:134:3::10]:48756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAgKI-0002tc-4T
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAgKH-000287-7h
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:04:18 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:45232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAgKH-000271-11
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:04:17 -0400
Received: by mail-wm0-x22d.google.com with SMTP id y80so3131154wmd.0
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 11:04:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171103153333.6416-1-berrange@redhat.com>
References: <20171103153333.6416-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 18:03:55 +0000
Message-ID: <CAFEAcA-n7jLjBcCAG6r30F=UUZy8vAKfMK8oC3oM+K1QTsH0zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Various improvements/bugfixes to
 submodule handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 3 November 2017 at 15:33, Daniel P. Berrange <berrange@redhat.com> wrote:
> This short series of patches improves the reliability of the submodule
> handling to cope with various dev env scenarios that have since emerged

Can I ask you to write up a bit for the release notes at
https://wiki.qemu.org/ChangeLog/2.11#Build_Information
covering what users need to know about the new submodule
handling, please?

thanks
-- PMM
