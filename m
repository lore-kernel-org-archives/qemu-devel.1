Received: from eggs.gnu.org ([2001:4830:134:3::10]:45737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gVMCR-00013h-Fi
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 14:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gVMCO-0004S0-AV
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 14:54:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gVMCO-0004Rn-4W
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 14:54:08 -0500
Date: Fri, 7 Dec 2018 17:54:00 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181207195400.GF7395@habkost.net>
References: <20181205194701.17836-1-danielhb413@gmail.com>
	<87pnufjg3t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnufjg3t.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v11 0/3] wakeup-from-suspend and
 system_wakeup changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, mst@redhat.com, mdroth@linux.vnet.ibm.com, imammedo@redhat.com

On Thu, Dec 06, 2018 at 07:59:02AM +0100, Markus Armbruster wrote:
> Daniel Henrique Barboza <danielhb413@gmail.com> writes:
> 
> > changes in v11:
> > - fixed typos, changed version to 4.0 in patches 1 and 3
> > - changed text in patch 2 to be less alarming
> > - patch 3: changed error handling
> > - previous version link:
> > http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg01774.html
> 
> Looks ready to me.  Who's going to merge it?

Do you mind merging it through the QMP tree?

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
