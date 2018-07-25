Received: from eggs.gnu.org ([2001:4830:134:3::10]:40367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fiMXU-00074K-RR
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 12:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fiMXR-0001xk-PB
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 12:21:24 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <c2f864e7-4009-e86d-ebd4-6ddea71df5e0@de.ibm.com> (Christian
	Borntraeger's message of "Wed, 25 Jul 2018 15:52:19 +0200")
References: <1532521224-27235-1-git-send-email-thuth@redhat.com>
	<c2f864e7-4009-e86d-ebd4-6ddea71df5e0@de.ibm.com>
Reply-To: quintela@redhat.com
Date: Wed, 25 Jul 2018 18:21:03 +0200
Message-ID: <87effrffrk.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 00/10] Move virtio-ccw devices to
 separate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> Are you planning to do a similar thing for virtio-pci? I think it would be good
> to keep virtio-ccw similar to virtio-pci when it makes sense.

+1 to that.

Later, Juan.
