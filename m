Received: from eggs.gnu.org ([2001:4830:134:3::10]:50266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk96e-0004Q5-8Y
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk96a-0006wR-8X
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:20:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dk96Z-0006sF-WF
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:20:28 -0400
References: <1503049022-14749-1-git-send-email-hare@suse.de>
	<09f093ef-a073-7374-0f40-330febc7c196@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <04707d3f-118b-aeaa-0c4c-89ccb1475820@redhat.com>
Date: Tue, 22 Aug 2017 15:20:23 +0200
MIME-Version: 1.0
In-Reply-To: <09f093ef-a073-7374-0f40-330febc7c196@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi-bus: correct responses for INQUIRY
 and REQUEST SENSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc: qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.com>

On 19/08/2017 00:55, Laszlo Ersek wrote:
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Fixes: ded6ddc5a7b95217557fa360913d1213e12d4a6d

And also:

Cc: qemu-stable@nongnu.org


Thanks to both!

Paolo
