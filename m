Received: from eggs.gnu.org ([2001:4830:134:3::10]:57865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZ5fA-0004ft-6t
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 20:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZ5f7-0001RZ-5L
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 20:58:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eZ5f6-0001Qa-Vm
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 20:58:41 -0500
Date: Wed, 10 Jan 2018 09:58:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180110015837.GB18027@lemon.usersys.redhat.com>
References: <CAJSP0QUMA7v=-qX-CNCi30aoH-HzXC9i75EpLWP_TmFuDzpTQQ@mail.gmail.com>
	<CAKmqyKPk69_d-iYGekoS9WBM1fnzav1iFAQEXQq_jLOW9_Dt3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKPk69_d-iYGekoS9WBM1fnzav1iFAQEXQq_jLOW9_Dt3w@mail.gmail.com>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Jailhouse <jailhouse-dev@googlegroups.com>

On Tue, 01/09 13:45, Alistair Francis wrote:
> On Tue, Jan 2, 2018 at 12:23 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > QEMU will apply to the Google Summer of Code
> > (https://summerofcode.withgoogle.com/) and Outreachy
> > (https://www.outreachy.org/) open source internship programs again
> > this year.
> >
> > Do you want to mentor newcomers beginning open source development in
> > our community?
> >
> > Please post your project ideas on the wiki by January 23rd:
> > https://wiki.qemu.org/Google_Summer_of_Code_2018
> >
> > Project ideas must:
> >  * Be doable in 12 weeks by someone fluent in C programming but not
> > familiar with the codebase.
> >  * Have a clear scope and few dependencies.
> >  * Have a high chance of being merged.
> >  * Consist of smaller steps that can be merged incrementally.
> >
> > Active QEMU, KVM, and Jailhouse contributors are invited to become
> > mentors.  Mentoring is a volunteer activity that requires around 5
> > hours per week to interact with your intern, review code, etc.  GSoC
> > and Outreachy internships run from May through August.
> >
> > For background on why QEMU participates in open source internship
> > programs and how it works, check out my KVM Forum presentation:
> > https://www.youtube.com/watch?v=xNVCX7YMUL8
> > https://vmsplice.net/~stefan/stefanha-kvm-forum-2016.pdf
> >
> > KVM and Jailhouse are invited to participate under the QEMU GSoC
> > umbrella organization.
> >
> > Please let me know if you have any questions!
> 
> Hey,
> 
> Can anyone who has done this before chime in.
> 
> What do you think about getting someone to cleanup and improve the GDB
> support in QEMU? Would that be the right difficulty of task for a GSoC
> project?

Yeah. I don't know much about GDB stub in QEMU but it sounds like a good idea if
the requirements (what exactly to improve) are concrete.  In general, a few
factors to consider are:

* Is it managable for a student who is not familiar with QEMU code but has fair
  proficiency in C and Linux programming?
* Is it roughly 3 months' (full time) amount of work for such a student?
* Is there a mentor that can guide and help (like said above, devote a few hours
  every week in the process, meeting with the student, answering questions and
  reviewing patches)?

Fam
