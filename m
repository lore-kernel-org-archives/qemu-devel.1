Received: from eggs.gnu.org ([2001:4830:134:3::10]:32954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0RlF-0005tR-HD
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0RlB-0001dj-Np
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:34:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1g0RlB-0001d1-Hw
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:34:17 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E393B308421A
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 13:34:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180903222758.13267-1-quintela@redhat.com> (Juan Quintela's
	message of "Tue, 4 Sep 2018 00:27:53 +0200")
References: <20180903222758.13267-1-quintela@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 13 Sep 2018 15:33:51 +0200
Message-ID: <8736udr074.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 0/5] Migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Juan Quintela <quintela@redhat.com> wrote:
> The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd241557452:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27-v2' into staging (2018-08-27 16:44:20 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20180903
>
> for you to fetch changes up to a28652cd4c138e9ed5d7dd9f7d10e3562f89ccac:
>
>   Add a hint message to loadvm and exits on failure (2018-09-03 19:50:42 +0200)

Nack myself.  This is included on the following migration pull.

Later, Juan
