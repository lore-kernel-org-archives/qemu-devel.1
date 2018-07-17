Received: from eggs.gnu.org ([2001:4830:134:3::10]:35930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffPHQ-0000LS-IR
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffPHL-0000bC-N0
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:40:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40738 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffPHL-0000Zt-Fg
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:40:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB44577885
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:40:30 +0000 (UTC)
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-19-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <593a889d-71e8-97ff-ab1c-b74b369f24ab@redhat.com>
Date: Tue, 17 Jul 2018 14:40:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180717113402.5510-19-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/25] check: Only test pvpanic when it is
 compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 17.07.2018 13:33, Juan Quintela wrote:
> There was not possible to compile out pvpanic.  Use the same trick
> that applesmc.

Either "It is not possible" or "There is no possibility" ? And that
"that" in the second sentence also sounds wrong.

Apart from that:

Reviewed-by: Thomas Huth <thuth@redhat.com>
