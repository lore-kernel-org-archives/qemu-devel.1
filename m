Received: from eggs.gnu.org ([2001:4830:134:3::10]:55446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCn2y-0007DV-HM
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCn2x-0005VC-UQ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:43:40 -0400
References: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
	<f47b81dbce734e9806f9516eba8ca588e6321c2f.1539764043.git.artem.k.pisarenko@gmail.com>
	<20181017091204.GC22755@stefanha-x1.localdomain>
	<5a83aab6-1277-cc0e-7913-964a8fea5265@redhat.com>
	<CANzW0mvPxvDsCURzXjOdjR-8uLjXpyAouH80ik6asb0awwX+VA@mail.gmail.com>
	<c9cfbdff-f713-b49d-4ac8-33ed79b08502@redhat.com>
	<CANzW0msXvjLESn2o559dOybWZvkRpFDuihSMGu6eZDBFOt_bFg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c51b114a-7064-acac-0fe9-34fc1187d15c@redhat.com>
Date: Wed, 17 Oct 2018 16:43:18 +0200
MIME-Version: 1.0
In-Reply-To: <CANzW0msXvjLESn2o559dOybWZvkRpFDuihSMGu6eZDBFOt_bFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/4] Introduce attributes
 to qemu timer subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, "open list:Block I/O path" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 17/10/2018 15:07, Artem Pisarenko wrote:
> Yes, but without words ..."when they fire" in attributes comments.

For now the only attribute applies when timers fire; that sentence was a
way to clarify the intended scope and address Stefan's comment.  I can
remove it too, but I'd like to understand if you have other ideas for
attributes.

Paolo
