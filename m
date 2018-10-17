Received: from eggs.gnu.org ([2001:4830:134:3::10]:59633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCnH3-0004Ao-Fu
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCnGx-000623-Nf
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:58:09 -0400
MIME-Version: 1.0
References: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
	<f47b81dbce734e9806f9516eba8ca588e6321c2f.1539764043.git.artem.k.pisarenko@gmail.com>
	<20181017091204.GC22755@stefanha-x1.localdomain>
	<5a83aab6-1277-cc0e-7913-964a8fea5265@redhat.com>
	<CANzW0mvPxvDsCURzXjOdjR-8uLjXpyAouH80ik6asb0awwX+VA@mail.gmail.com>
	<c9cfbdff-f713-b49d-4ac8-33ed79b08502@redhat.com>
	<CANzW0msXvjLESn2o559dOybWZvkRpFDuihSMGu6eZDBFOt_bFg@mail.gmail.com>
	<c51b114a-7064-acac-0fe9-34fc1187d15c@redhat.com>
In-Reply-To: <c51b114a-7064-acac-0fe9-34fc1187d15c@redhat.com>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Wed, 17 Oct 2018 20:57:51 +0600
Message-ID: <CANzW0ms7MhqcPa0BO0s=JBV=jyOTU0EWMc-3Mnwb23O-uyUu4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, "open list:Block I/O path" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

>=D1=81=D1=80, 17 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 20:43, Paolo Bonz=
ini:
>On 17/10/2018 15:07, Artem Pisarenko wrote:
>> Yes, but without words ..."when they fire" in attributes comments.
>
> For now the only attribute applies when timers fire; that sentence was a
> way to clarify the intended scope and address Stefan's comment.  I can
> remove it too, but I'd like to understand if you have other ideas for
> attributes.

No, I haven't. I don't think that this partcular narrowing has any
relevance to Stefan's comment, so I just considered it to be unnecessary. I
don't insist.
--=20

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE
