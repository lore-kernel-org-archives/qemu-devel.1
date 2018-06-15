Received: from eggs.gnu.org ([2001:4830:134:3::10]:42018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tamiko@43-1.org>) id 1fTw1h-0006Ud-7l
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 17:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tamiko@43-1.org>) id 1fTw1c-00077g-8s
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 17:12:57 -0400
Received: from tsukuyomi.43-1.org ([188.40.248.50]:52098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tamiko@43-1.org>) id 1fTw1c-00076K-1I
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 17:12:52 -0400
From: Matthias Maier <tamiko@43-1.org>
In-Reply-To: <20180615203425.GF7451@localhost.localdomain> (Eduardo Habkost's
	message of "Fri, 15 Jun 2018 17:34:25 -0300")
References: <20180614154357.20132-1-tamiko@43-1.org>
	<20180614154357.20132-2-tamiko@43-1.org>
	<20180615203425.GF7451@localhost.localdomain>
Date: Fri, 15 Jun 2018 16:12:46 -0500
Message-ID: <87in6jpxdd.fsf@43-1.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] Partially revert commit d4e5ec877ca
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>


On Fri, Jun 15, 2018, at 15:34 CDT, Eduardo Habkost <ehabkost@redhat.com> wrote:

> Thanks for the patches.  It's nice to see that hack go away.
>
> Patch 2/2 is necessary to make the removal of PYTHON_UTF8 safe,
> correct?  In that case, I plan to reverse the order of the
> patches before applying.

Yes, the order of the patches should be reversed.
