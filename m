Received: from eggs.gnu.org ([2001:4830:134:3::10]:40166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <iank@fsf.org>) id 1eLxcq-0008PB-E8
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:46:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <iank@fsf.org>) id 1eLxcn-0006aH-Ba
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:46:04 -0500
Received: from li.iankelling.org ([72.14.176.105]:58734
	helo=mail.iankelling.org)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <iank@fsf.org>) id 1eLxcn-0006a2-3T
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:46:01 -0500
References: <87bmjeqn1s.fsf@fsf.org>
	<fbff6cd8-e3b8-3baa-b54d-87ce385061d6@redhat.com>
From: Ian Kelling <iank@fsf.org>
In-reply-to: <fbff6cd8-e3b8-3baa-b54d-87ce385061d6@redhat.com>
Date: Mon, 04 Dec 2017 15:45:59 -0500
Message-ID: <87a7yyql14.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] qemu-devel archive search was missing some
 messages but it's fixed now
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org

Laszlo Ersek <lersek@redhat.com> writes:

> Hello Ian,
>
> On 12/04/17 21:02, Ian Kelling wrote:
>
>> General thoughts about the archive: I'm looking forward to us upgrading
>> to mailman 3 at some point which will bring an improved archive
>> interface.
>
> Do you mean HyperKitty?

Yes.

>
> Will you seek out community feedback on it first?

Yes, of course. And I expect the old interface to continue to exist
alongside it indefinitely.

>
>> Of course, you can always download the archive and search it
>> on your local computer.
>
> The one HyperKitty instance that I can readily look at is:
>
> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/
>
> It only offers the following download options:
>
> - "Past 30 days (mbox)"
> - "This month (mbox)"
> - "Entire archive (mbox)"
>
> Maybe it's configurable site by site, but I find this lacking compared
> to: "download whichever month you want, in isolation", which is offered
> by mailman2:
>
> ftp://lists.gnu.org/qemu-devel/
>
> If someone needs it all, the latter remains easy to script with wget,
> for example.
>
> (Back to my original point -- judged similarly from the fedora devel
> archive, I find HyperKitty hardly usable for normal reading, and I think
> it will completely fail for patch series threads and the discussions
> under them. HyperKitty is a step towards social media in my opinion, and
> as such inappropriate for development lists (again, IMO). I'm happy to
> learn otherwise, of course -- are there good counter-examples where
> HyperKitty has worked out fine, for archiving email-based patch traffic
> and development discussion?)
>
> NB: my opinion on this likely doesn't matter, as I'm not a heavy
> qemu-devel contributor.

And you've given some reasons why :)

-- 
Ian Kelling | Senior Systems Administrator, Free Software Foundation
GPG Key: B125 F60B 7B28 7FF6 A2B7  DF8F 170A F0E2 9542 95DF
https://fsf.org | https://gnu.org
