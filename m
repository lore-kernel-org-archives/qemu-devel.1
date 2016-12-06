Received: from eggs.gnu.org ([2001:4830:134:3::10]:56940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cEH78-0000js-9Q
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cEH74-0002kX-CP
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:53:02 -0500
Received: from mail-wj0-f179.google.com ([209.85.210.179]:35586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cEH74-0002jz-6F
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:52:58 -0500
Received: by mail-wj0-f179.google.com with SMTP id v7so323982596wjy.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 06:52:57 -0800 (PST)
References: <20161206113915.26308.72810.malonedeb@wampee.canonical.com>
	<20161206114637.26046.68333.malone@wampee.canonical.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20161206114637.26046.68333.malone@wampee.canonical.com>
Date: Tue, 06 Dec 2016 14:51:55 +0000
Message-ID: <87lgvtyut0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Bug 1647683] Re: Bad interaction between tb
 flushing & gdb stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1647683 <1647683@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


Julian Brown <1647683@bugs.launchpad.net> writes:

> (FAOD, the crashes happen without Valgrind too, and the above backtrace
> may be a red herring.)

I've sent a patch that should fix this. Could you please test?

--
Alex Bennée
