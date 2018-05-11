Received: from eggs.gnu.org ([2001:4830:134:3::10]:34007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fHAwd-0007gT-Cu
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fHAwZ-0004Bh-Jo
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:30:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40480 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fHAwZ-0004Ba-F5
	for qemu-devel@nongnu.org; Fri, 11 May 2018 12:30:55 -0400
Date: Fri, 11 May 2018 17:30:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180511163050.GQ22098@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <bdfbc910-4a08-98ae-563d-96090f0f381a@mail.ru>
	<CAJSP0QXnKJemDtZVOOgktwAawRUto25E1i-JjggKsviN4iuS5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QXnKJemDtZVOOgktwAawRUto25E1i-JjggKsviN4iuS5A@mail.gmail.com>
Subject: Re: [Qemu-devel] Outreachy intro: micro:bit project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Julia Suvorova <jusual@mail.ru>, Jim Mussared <jim@groklearning.com>, qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>

On Fri, May 11, 2018 at 05:13:31PM +0100, Stefan Hajnoczi wrote:
> On Thu, May 10, 2018 at 11:19 PM, Julia Suvorova <jusual@mail.ru> wrote:
> > My name is Julia. I am a bachelor of mathematics from Moscow who is
> > interested in system programming. I've been selected for Outreachy this
> > year to work on the micro:bit project.
> > The project is divided between two people - me and Steffen.
> > We will develop support for the micro:bit board and the Cortex-M0 cpu.
> >
> > I'm very excited to work with QEMU community. Wish me luck!
> 
> Congratulations!  We are excited to work with you.
> 
> Do you have a blog URL where we can follow your work?
> 
> You can add it to the open source virtualization blog aggregator here
> by contacting Daniel Berrange <berrange@redhat.com> (and follow the
> aggregator to see what others are doing!):
> https://planet.virt-tools.org/

We maintain it in public GIT now, so people can just clone the repo here,
add their blog details (see recent commits for example of what needs
changing), then send the patch to libvir-list@redhat.com for review

  https://libvirt.org/git/?p=virttools-planet.git;a=summary

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
