Received: from eggs.gnu.org ([2001:4830:134:3::10]:40102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmD2R-0004eq-Gj
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 01:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmD2M-00050v-Ng
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 01:56:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmD2M-00050W-HZ
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 01:56:38 -0400
Date: Mon, 28 Aug 2017 13:56:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170828055628.GK14174@pxdev.xzpeter.org>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-4-git-send-email-peterx@redhat.com>
	<20170826071939.GA9564@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170826071939.GA9564@lemon.lan>
Subject: Re: [Qemu-devel] [RFC v2 3/8] char-io: fix possible risk on
 IOWatchPoll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Sat, Aug 26, 2017 at 03:19:39PM +0800, Fam Zheng wrote:
> s/risk/race/ for $subject and the whole patch?

I think... Yes. :-)  Thanks.

-- 
Peter Xu
