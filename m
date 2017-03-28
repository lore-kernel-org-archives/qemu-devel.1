Received: from eggs.gnu.org ([2001:4830:134:3::10]:44409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csok3-00080b-Ed
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csojy-0003wn-Hw
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:52:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1csojy-0003wU-Bj
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:52:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31669C054C58
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 10:52:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <5172eb13-0183-52a8-32af-4b37468ded67@redhat.com> (Eric Blake's
	message of "Fri, 24 Mar 2017 12:15:30 -0500")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-3-quintela@redhat.com>
	<5172eb13-0183-52a8-32af-4b37468ded67@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 28 Mar 2017 12:52:39 +0200
Message-ID: <871sthsmfc.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/51] ram: rename block_name to rbname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Eric Blake <eblake@redhat.com> wrote:
> On 03/23/2017 03:44 PM, Juan Quintela wrote:
>> So all places are consisten on the nambing of a block name parameter.
>
> s/consisten/consistent/
> s/nambing/naming/

Done, thanks.
