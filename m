Received: from eggs.gnu.org ([2001:4830:134:3::10]:53394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiNNf-000055-9g
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 13:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiNNc-0001XR-2v
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 13:15:19 -0400
References: <1532521224-27235-1-git-send-email-thuth@redhat.com>
	<c2f864e7-4009-e86d-ebd4-6ddea71df5e0@de.ibm.com>
	<87effrffrk.fsf@secure.mitica>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <be123710-869d-1525-38ae-f370f2cad40a@redhat.com>
Date: Wed, 25 Jul 2018 19:15:11 +0200
MIME-Version: 1.0
In-Reply-To: <87effrffrk.fsf@secure.mitica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: quintela@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 25.07.2018 18:21, Juan Quintela wrote:
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>> Are you planning to do a similar thing for virtio-pci? I think it woul=
d be good
>> to keep virtio-ccw similar to virtio-pci when it makes sense.

Somebody=E2=84=A2 should do it, yes. For the context, see:
 https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03935.html

> +1 to that.

I was hoping that you would take care of the pci while I'm handling the
ccw part, Juan ;-) But if you don't have spare time for this at all, I
can also put it on my todo list.

 Thomas
