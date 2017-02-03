Received: from eggs.gnu.org ([2001:4830:134:3::10]:44906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cZaDb-0001xY-Ia
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cZaDY-0000JZ-E7
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:31:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:33165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cZaDY-0000JC-7z
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:31:44 -0500
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1486114065.16444.17.camel@redhat.com>
Date: Fri, 3 Feb 2017 10:31:39 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC7C3C40-92A9-454B-87E7-6BE7286719A6@suse.de>
References: <32ff6fa9-696a-f4a2-e884-3b22f91506e5@iki.fi>
	<1486114065.16444.17.camel@redhat.com>
Subject: Re: [Qemu-devel] KVM/QEMU on Raspberry Pi 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Pekka Enberg <penberg@iki.fi>, kvm@vger.kernel.org, qemu-devel@nongnu.org



> Am 03.02.2017 um 10:27 schrieb Gerd Hoffmann <kraxel@redhat.com>:
>=20
>> On Do, 2017-02-02 at 16:44 +0200, Pekka Enberg wrote:
>> Hi,
>>=20
>> Has anyone been able to successfully run QEMU/KVM under Raspberry Pi 3?
>=20
> Yes.  The bits are not yet upstream though (Cc'ing alex for status).

Ugh, the patches fell through the cracks. I think we basically all agreed on=
 the interfaces, I just need to dig through my inbox and figure out again wh=
ere they got stuck.

I won't get to it before Fosdem, but after I'll make sure it's high on the t=
odo list.


Alex
