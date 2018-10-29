Received: from eggs.gnu.org ([2001:4830:134:3::10]:42655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHBvr-0002uX-HB
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 14:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHBvp-0001ZM-Il
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 14:06:31 -0400
References: <20180626135035.133432-5-vsementsov@virtuozzo.com>
	<700dffe4-f3a8-8f70-052c-9f6f8ffbe3d3@redhat.com>
	<20180801102031.GC2691@work-vm>
	<64aad02b-3d5c-70d6-0f5a-93dd5b88e4bc@redhat.com>
	<20180801174005.GD2691@work-vm>
	<cbdecba1-925c-5f6e-bf3c-a27cc4d944da@openvz.org>
	<20180801185515.GE2691@work-vm>
	<6bfdc952-fb17-feae-f367-be710853d829@openvz.org>
	<20180802092907.GA2523@work-vm>
	<202065a2-f9d1-ce31-b12b-437d57095ac1@openvz.org>
	<20180802095056.GB2523@work-vm>
	<86304a35-efd8-a605-f684-2bd3fb3b9815@openvz.org>
	<1e41d103-6d56-71e8-ef60-fc4c9343a06e@redhat.com>
	<6d8ed319-9b63-5a7b-fcfe-20cd37cf8c7c@virtuozzo.com>
	<d2538432-be74-99bc-72d1-94f8abaa2f9b@redhat.com>
	<26c0e008-898d-924a-214e-68ab9fedf1ea@virtuozzo.com>
	<72f7a1bd-940d-475f-ceb6-cd105fe02e2b@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8d9aae15-8608-2cb1-1ea5-567675b6a077@redhat.com>
Date: Mon, 29 Oct 2018 14:06:15 -0400
MIME-Version: 1.0
In-Reply-To: <72f7a1bd-940d-475f-ceb6-cd105fe02e2b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ping2 Re: [PATCH 4/6] dirty-bitmaps: clean-up
 bitmaps loading and migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "quintela@redhat.com" <quintela@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>



On 10/29/2018 01:52 PM, Vladimir Sementsov-Ogievskiy wrote:
> ping2
> 
> Hi, what about this finally? Looks like everyone see a lot of comments 
> and thing, that there should be a new version, but actually, there is 
> almost unrelated discussion and/or answered questions. Only rephrasing 
> by Eric in patch 2 may be applied, to change something.
> The series fix the bug in bitmaps migration, look at patch 5.
> 

Yeah, I'm not sure of the comments but we can patch them up later. I've
been sick for the last two weeks and then I just got back from KVM
Forum. Running some tests now and will send a PR out.

We'll change what we need to for the RC.

--js
