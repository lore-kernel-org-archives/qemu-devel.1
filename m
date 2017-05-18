Received: from eggs.gnu.org ([2001:4830:134:3::10]:38192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBLC0-0006d3-O9
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBLBu-0008Nn-TH
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:10:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBLBu-0008ND-NH
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:10:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE43B4E4C4
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 13:10:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170518121547.GD2467@work-vm> (David Alan Gilbert's message of
	"Thu, 18 May 2017 13:15:48 +0100")
References: <20170518111837.29212-1-quintela@redhat.com>
	<20170518121547.GD2467@work-vm>
Reply-To: quintela@redhat.com
Date: Thu, 18 May 2017 15:10:04 +0200
Message-ID: <8760gy9uqb.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/5] Remove old MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, eblake@redhat.com, armbru@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Hi
>> 
>> Changes from v4:
>> - make suggested logic change by eric
>> - remove extra space in error message
>> - allow migrate_set_capability block off when block migration is complied off
>>   (eric request)
>
> Hang on, is this v6? I think you've missed the '-v'

Yeap, sorry.

The '-v': Old dog learning new tricks.

Later, Juan.
