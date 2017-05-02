Received: from eggs.gnu.org ([2001:4830:134:3::10]:38558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d5Swa-0004U8-3M
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d5SwZ-0003jM-3z
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:14:00 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170428021317.24711-1-eblake@redhat.com>	<20170428021317.24711-4-eblake@redhat.com>
	<87h918bmpz.fsf@dusky.pond.sub.org>
In-Reply-To: <87h918bmpz.fsf@dusky.pond.sub.org>
Date: Tue, 2 May 2017 11:13:51 +0300
Message-ID: <000d01d2c31c$091afd30$1b50f790$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v5 3/4] shutdown: Add source information to
 SHUTDOWN and RESET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Markus Armbruster' <armbru@redhat.com>, 'Eric Blake' <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, 'Peter Maydell' <peter.maydell@linaro.org>, "'open list:Overall'" <kvm@vger.kernel.org>, "'Michael S. Tsirkin'" <mst@redhat.com>, 'Mark Cave-Ayland' <mark.cave-ayland@ilande.co.uk>, 'Alexander Graf' <agraf@suse.de>, 'Yongbok Kim' <yongbok.kim@imgtec.com>, 'Gerd Hoffmann' <kraxel@redhat.com>, "'Edgar E. Iglesias'" <edgar.iglesias@gmail.com>, 'Rob Herring' <robh@kernel.org>, 'Stefano Stabellini' <sstabellini@kernel.org>, "'open list:Block layer core'" <qemu-block@nongnu.org>, 'Magnus Damm' <magnus.damm@gmail.com>, 'Christian Borntraeger' <borntraeger@de.ibm.com>, 'Anthony Perard' <anthony.perard@citrix.com>, "'open list:X86'" <xen-devel@lists.xenproject.org>, 'Richard Henderson' <rth@twiddle.net>, 'Artyom Tarasenko' <atar4qemu@gmail.com>, 'Eduardo Habkost' <ehabkost@redhat.com>, 'Stefan Weil' <sw@weilnetz.de>, alistair.francis@xilinx.com, "'open list:Calxeda Highbank'" <qemu-arm@nongnu.org>, 'Jan Kiszka' <jan.kiszka@web.de>, 'Igor Mammedov' <imammedo@redhat.com>, 'Cor nelia Hu ck' <cornelia.huck@de.ibm.com>, 'David Gibson' <david@gibson.dropbear.id.au>, 'Kevin Wolf' <kwolf@redhat.com>, 'Paul Burton' <paul.burton@imgtec.com>, 'Max Filippov' <jcmvbkbc@gmail.com>, 'Marcelo Tosatti' <mtosatti@redhat.com>, 'Max Reitz' <mreitz@redhat.com>, 'Michael Walle' <michael@walle.cc>, "'open list:Old World'" <qemu-ppc@nongnu.org>, 'Paolo Bonzini' <pbonzini@redhat.com>, 'Aurelien Jarno' <aurelien@aurel32.net>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

> From: Markus Armbruster [mailto:armbru@redhat.com]
> 
> Scandalously, replay/ is not covered by MAINTAINERS.

Here it is.
http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg00080.html

I'll try to figure out the SHUTDOWN problem.

Pavel Dovgalyuk
