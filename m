Received: from eggs.gnu.org ([2001:4830:134:3::10]:50547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0ZOz-0003ek-Eh
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 16:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0ZOv-00017U-CT
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 16:07:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0ZOv-000176-6h
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 16:07:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34A3361B8F
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 20:07:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170418180253.GN2205@work-vm> (David Alan Gilbert's message of
	"Tue, 18 Apr 2017 19:02:53 +0100")
References: <20170417200041.2451-1-quintela@redhat.com>
	<20170417200041.2451-20-quintela@redhat.com>
	<20170418180253.GN2205@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 18 Apr 2017 22:06:58 +0200
Message-ID: <87k26hh44d.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 19/19] monitor: remove monitor parameter
 from save_vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg03927.html

Damn thing.  And I did it by hand (not that it was very difficult).

Added bonus is that I have already changed load_vmstate on the same
patch.

Will post them on next respin.

Later, Juan.
