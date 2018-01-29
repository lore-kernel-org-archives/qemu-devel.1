Received: from eggs.gnu.org ([2001:4830:134:3::10]:38433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eg63r-0000XO-HB
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 04:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eg63n-0004aI-3g
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 04:49:11 -0500
Date: Mon, 29 Jan 2018 10:48:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180129104859.271604ea.cohuck@redhat.com>
In-Reply-To: <850220a3-c726-f7cf-e132-3bbe376427c0@redhat.com>
References: <20180117174047.6382-1-david@redhat.com>
	<20180117174047.6382-13-david@redhat.com>
	<20180125112659.3c08063d.cohuck@redhat.com>
	<438493f5-d66f-0bb6-4db2-59dd4d5b556e@redhat.com>
	<20180125145100.5029d8c2.cohuck@redhat.com>
	<850220a3-c726-f7cf-e132-3bbe376427c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 12/18] s390x: fix size +
 content of STSI blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, 29 Jan 2018 10:42:33 +0100
David Hildenbrand <david@redhat.com> wrote:

> If there are no further comments, I can resend.

Other than the wrong cr check, I did not have any complaints.
