Received: from eggs.gnu.org ([2001:4830:134:3::10]:38184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eyHjB-0004vD-M0
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eyHjA-0004O4-LS
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:55:01 -0400
References: <1521510562-529051-1-git-send-email-mst@redhat.com>
	<8f06e1e3-4823-d8e8-43bd-c092c523849e@vivier.eu>
	<20180320094406.GD4530@redhat.com>
	<20180320141107-mutt-send-email-mst@kernel.org>
	<20180320121841.GN4530@redhat.com>
	<20180320142756-mutt-send-email-mst@kernel.org>
	<20180320123900.GO4530@redhat.com>
	<20180320133216.u4hdijttdnyjbfpu@sirius.home.kraxel.org>
	<20180320134117.GS4530@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8e14f681-6572-062b-c503-c5ad091793d7@redhat.com>
Date: Tue, 20 Mar 2018 14:54:37 +0100
MIME-Version: 1.0
In-Reply-To: <20180320134117.GS4530@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3bVcvjt7gGf3BwAy0eGre8GNjlP4mR8zE"
Subject: Re: [Qemu-devel] [PATCH] qemu: include generated files with <> and
 not ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Josh Durgin <jdurgin@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, Ben Warren <ben@skyportsystems.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Michael Walle <michael@walle.cc>, Keith Busch <keith.busch@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Fabien Chouteau <chouteau@adacore.com>, Amit Shah <amit@kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, BALATON Zoltan <balaton@eik.bme.hu>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <minyard@acm.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Peter Chubb <peter.chubb@nicta.com.au>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Yuval Shaia <yuval.shaia@oracle.com>, David Hildenbrand <david@redhat.com>, Hannes Reinecke <hare@suse.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Andrzej Zaborowski <balrogg@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Riku Voipio <riku.voipio@iki.fi>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, kvm@vger.kernel.org, qemu-block@nongnu.org, sheepdog@lists.wpkg.org, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3bVcvjt7gGf3BwAy0eGre8GNjlP4mR8zE
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier
 <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Josh Durgin <jdurgin@redhat.com>,
 Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>,
 Liu Yuan <namei.unix@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>,
 Ben Warren <ben@skyportsystems.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>,
 Michael Walle <michael@walle.cc>, Keith Busch <keith.busch@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Fabien Chouteau <chouteau@adacore.com>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>, Alexander Graf <agraf@suse.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <minyard@acm.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Yuval Shaia <yuval.shaia@oracle.com>, David Hildenbrand <david@redhat.com>,
 Hannes Reinecke <hare@suse.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Andrzej Zaborowski <balrogg@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, Michael Roth
 <mdroth@linux.vnet.ibm.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?=
 <afaerber@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Riku Voipio <riku.voipio@iki.fi>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Wen Congyang
 <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, kvm@vger.kernel.org, qemu-block@nongnu.org,
 sheepdog@lists.wpkg.org, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Message-ID: <8e14f681-6572-062b-c503-c5ad091793d7@redhat.com>
Subject: Re: [PATCH] qemu: include generated files with <> and not ""
References: <1521510562-529051-1-git-send-email-mst@redhat.com>
 <8f06e1e3-4823-d8e8-43bd-c092c523849e@vivier.eu>
 <20180320094406.GD4530@redhat.com>
 <20180320141107-mutt-send-email-mst@kernel.org>
 <20180320121841.GN4530@redhat.com>
 <20180320142756-mutt-send-email-mst@kernel.org>
 <20180320123900.GO4530@redhat.com>
 <20180320133216.u4hdijttdnyjbfpu@sirius.home.kraxel.org>
 <20180320134117.GS4530@redhat.com>
In-Reply-To: <20180320134117.GS4530@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-20 14:41, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 20, 2018 at 02:32:16PM +0100, Gerd Hoffmann wrote:
>>   Hi,
>>
>>>> So for these, we should use "".  None of these are generated files t=
hough.
>>>
>>> That leads to crazy inconsistent message for developers where 50% of =
QEMU
>>> header files must use <> and the other 50% of header files must use "=
".
>>
>> The rules are pretty simple though:
>>
>>    (1) Headers which are generated use <>.
>>    (2) Headers which are in include/ use <>.
>>    (3) Headers sitting in the same directory as the source files use "=
".
>=20
> We have 1200 header files in QEMU - a developer might just reasonably r=
emember
> which header file is a QEMU header, vs which is a 3rd party system head=
er.
> Expecting devs to remember which of those 3 buckets each QEMU header fa=
lls
> under is unreasonable IMHO.=20

I agree with this in principle, but I don't find it unreasonable for
someone to look up whether a header file exists in the same directory.
I find that much simpler than to look up whether it is a system header,
actually.

And I have to agree with Michael that his rule when to use "" (if the
file is in the same directory) and when to use <> (otherwise) is
actually what every C developer might do by instinct.  (I guess it's
also easier to check in a script than the original guideline?)

However, I also think that if any problem arises because "" was used for
a generated file and that then uses a stale file, the bug is somewhere
else.  And I think that while Michael's proposal is the more intuitive
(C) way, it is a tiny bit more complicated to explain than 'Use "" for
qemu headers, <> for everything else'.

But I guess the main advantage with using this rule I see is that it's
better for people reading the code.  It's just nice to know whether a
file belongs to qemu or not by just looking at the #include statement.
(Note that this implies that it is indeed more difficult to determine
whether a header belongs to qemu than whether it sits in the same
directory as the C file, though!)  So I think the old (current) rule is
better for reading code, Michael's rule would be better for writing
code.  I think reading code is what should be easier.

But since that may be eaten up by build breakages due to stale files, I
don't have a strong opinion either way.  I just wanted to chime in
because in my opinion 'Use "" for headers in the same directory, <> for
everything else' is by no means an unreasonably complicated rule for
people writing code.

Max


--3bVcvjt7gGf3BwAy0eGre8GNjlP4mR8zE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqxEp0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJsUIAJd2GeUBJFTYmeKR5uxkvBIkRHGgRyAm
H76Sk1MnAhHTVPGKLoMDwweaSnCz+XAFo3P3YJJbFSNvaWUd3ZN8roiyOlPtYnNY
6cBk9GrLnzWW8VYmEkCP4xmA0Hkowm+IKD374TBqc17h3Fzxs1obPQJxhJ8xKpvH
dc10DJ6la/R+dyQAe8lTVBg5zXh44Q2zoslSvLVVE1PDcWlo+fIHai7eB5kzYyu3
jSKqdAoJvDD7d/FRndl37+Yb6AcbgUZP3U/7ntRE7Omk471b7FcoqN03GtlY0Unk
hxi0sjM6SAsgGtjEm0Jiqypwlq+luCn5ekS1JI7U+/4Lo2KC5EOLD6o=
=wiAH
-----END PGP SIGNATURE-----

--3bVcvjt7gGf3BwAy0eGre8GNjlP4mR8zE--
