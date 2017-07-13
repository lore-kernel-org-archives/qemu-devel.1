Received: from eggs.gnu.org ([2001:4830:134:3::10]:45131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVYbi-0001YB-Rd
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVYbf-0003mK-PO
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:32:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVYbf-0003lJ-JA
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:32:15 -0400
Date: Thu, 13 Jul 2017 09:32:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170713093211.2fa82759@gondolin>
In-Reply-To: <83795acd-ddfd-e039-80bb-78a785fb7669@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-4-git-send-email-borntraeger@de.ibm.com>
	<92a0944a-156a-6800-88f1-ae39b5263730@redhat.com>
	<83795acd-ddfd-e039-80bb-78a785fb7669@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/11] s390x/migration: Storage attributes
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On Thu, 13 Jul 2017 09:11:34 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Thanks for the review, all valid. Claudio has provided me the following fixup.
> 
> I plan to fold that in the base patch (retest pending).

Looks good to me, and I have no further comments beyond those by Thomas.
