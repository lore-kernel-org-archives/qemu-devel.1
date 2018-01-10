Received: from eggs.gnu.org ([2001:4830:134:3::10]:42928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eZFsB-0001wO-Qt
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eZFsA-0000cS-PP
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:52:51 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eZFsA-0000bp-Ig
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:52:50 -0500
Received: by mail-wr0-x231.google.com with SMTP id f8so17237643wre.4
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 04:52:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPk69_d-iYGekoS9WBM1fnzav1iFAQEXQq_jLOW9_Dt3w@mail.gmail.com>
References: <CAJSP0QUMA7v=-qX-CNCi30aoH-HzXC9i75EpLWP_TmFuDzpTQQ@mail.gmail.com>
	<CAKmqyKPk69_d-iYGekoS9WBM1fnzav1iFAQEXQq_jLOW9_Dt3w@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 10 Jan 2018 12:52:48 +0000
Message-ID: <CAJSP0QVd70uAiG3vyOjO-qOdt1YbEccYydJvz4igg7_bBiW+5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Call for GSoC & Outreachy 2018 mentors & project
 ideas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Jailhouse <jailhouse-dev@googlegroups.com>

On Tue, Jan 9, 2018 at 9:45 PM, Alistair Francis <alistair23@gmail.com> wrote:
> Can anyone who has done this before chime in.
>
> What do you think about getting someone to cleanup and improve the GDB
> support in QEMU? Would that be the right difficulty of task for a GSoC
> project?

There is not enough information to give feedback on whether this
project idea is suitable.  What are the specific tasks you'd like the
student to work on?

In general, I'm sure there are well-defined 12-week project ideas
around the GDB stub.  New features are easy to propose and are usually
well-defined (e.g. implement these commands that are documented in the
GDB protocol documentation).  Cleaning up code is less clear and it
would depend on exactly what needs to be done.  Interns will not have
a background in the QEMU codebase and may not be able to make
judgements about how to structure things, so I would be more careful
about refactoring/cleanup projects.

Please see my talk about QEMU GSoC for guidelines on project ideas:
https://www.youtube.com/watch?v=xNVCX7YMUL8&t=19m11s
http://vmsplice.net/~stefan/stefanha-kvm-forum-2016.pdf

Hope this helps,
Stefan
