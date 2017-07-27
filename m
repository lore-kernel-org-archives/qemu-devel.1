Received: from eggs.gnu.org ([2001:4830:134:3::10]:46603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1daZOK-0002B1-Mi
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 23:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1daZOF-0003fB-Ps
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 23:23:12 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:33757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1daZOF-0003er-Kt
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 23:23:07 -0400
Received: by mail-io0-x243.google.com with SMTP id q64so6951791ioi.0
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 20:23:07 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <68907037-02F0-465B-9D15-B1FBA7512F9D@gmail.com>
Date: Wed, 26 Jul 2017 23:23:04 -0400
Subject: Re: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84
 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>
Cc: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, Programmingkid <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, seabios@seabios.org

I just realized what we need in order to test QEMU better. We need a =
list of people who
are willing to support a certain operating system.=20

The list would probably be located here: =
http://wiki.qemu.org/Testing/Windows

It would look like this:


Operating system	Tester

Windows 3.1		<email address of a tester>, <email address of =
another tester>, ...
Windows NT 3.1		<email address of a tester>, <email address of =
another tester>, ...
Windows NT 3.5		<email address of a tester>, <email address of =
another tester>, ...
Windows 95		<email address of a tester>, <email address of =
another tester>, ...
Windows NT 4.0		<email address of a tester>, <email address of =
another tester>, ...
Windows 98		<email address of a tester>, <email address of =
another tester>, ...
Windows ME		<email address of a tester>, <email address of =
another tester>, ...
Windows 2000		<email address of a tester>, <email address of =
another tester>, ...
Windows XP		<email address of a tester>, <email address of =
another tester>, ...
Windows Vista		<email address of a tester>, <email address of =
another tester>, ...
Windows 7		<email address of a tester>, <email address of =
another tester>, ...
Windows 8		<email address of a tester>, <email address of =
another tester>, ...
Windows 10		<email address of a tester>, <email address of =
another tester>, ...
ReactOS			<email address of a tester>, <email address of =
another tester>, ...


If someone has a patch that makes a change to the qemu-system-i386 =
emulator,
the patch maker can consult the list of people who might be willing to =
help test the patch.=20
There are many people who work on QEMU with certain versions of Windows =
at their
disposal. With this knowledge compatibility testing can become more =
thorough.
Thoughts? Ideas?=
