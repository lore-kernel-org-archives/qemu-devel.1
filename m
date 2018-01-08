Received: from eggs.gnu.org ([2001:4830:134:3::10]:58383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eYfae-0003h2-0o
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eYfaY-0007dw-Vd
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:08:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eYfaY-0007dU-MH
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:08:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E78FBA451C
	for <qemu-devel@nongnu.org>; Mon,  8 Jan 2018 22:08:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180105170138.23357-2-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 5 Jan 2018 17:01:37 +0000")
References: <20180105170138.23357-1-dgilbert@redhat.com>
	<20180105170138.23357-2-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 08 Jan 2018 23:08:11 +0100
Message-ID: <87o9m40zsk.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] find_ram_offset: Add comments and
 tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Add some comments so I can understand the various nested loops.
> Add some tracing so I can see what they're doing.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


Reviewed-by: Juan Quintela <quintela@redhat.com>
