Received: from eggs.gnu.org ([2001:4830:134:3::10]:56740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cVgX8-0006ND-VW
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cVgX7-0005qo-KD
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:27:50 -0500
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed;
	boundary="Apple-Mail=_91F22967-4FB3-488A-A40C-A44E504947BD";
	protocol="application/pgp-signature"; micalg=pgp-sha512
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
Date: Mon, 23 Jan 2017 15:27:36 +0000
Message-Id: <BC54339E-18A1-4FCB-8719-08CC1AF18169@alex.org.uk>
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
	<e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
	<2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
	<CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
	<CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
	<90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
	<20170114144500.oxoqvrn5x4sdfo74@grep.be>
	<1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
	<20170118080126.nyldkjhxdsxd4u2b@grep.be>
	<CAMxP3BTjBSQEhycavgyfWXEA6pTg=sxfHe5sf+nxVY9ejXWMXQ@mail.gmail.com>
	<20170122114339.l3ijhy3uymsru4ed@grep.be>
	<4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
Subject: Re: [Qemu-devel] [Nbd] [Qemu-block] How to online resize qemu disk
 with nbd protocol?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>, Bob Chen <a175818323@gmail.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>


--Apple-Mail=_91F22967-4FB3-488A-A40C-A44E504947BD
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On 23 Jan 2017, at 14:54, Eric Blake <eblake@redhat.com> wrote:
> 
> Thoughts?

My main thought is that the purpose of the extension branches is
to discuss and come to a consensus over experimental extension protocols.
Whilst I think creating a branch should be a lightweight affair
(fine), we explicitly say people should know the implications
of using extensions in shipping code - specifically that the
specification may change!

--
Alex Bligh





--Apple-Mail=_91F22967-4FB3-488A-A40C-A44E504947BD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJYhiDoAAoJEBPm5K7i9iORKYgP/jXBmwF7GS4010BK/2rmPjVu
8jDLkGCTU0bi0Ng24KGw9qN0F1VBWKGNn+mPzy/xQGZCsZ2zczWa+XJzXG95P0z0
9Q+wLPSBxtKkcOspTLcC2bmojSSqdcD3QOjuO+VhZSfEn+J9oVcoX1kFmDec7+7Z
dt1UoitmpgJEkco5mjwKdnzR6CgOsqvvptVos+CJ+c5geVGoYycT8Txy0u5cbZGk
rqCapaMdwPVFXFCV1//cP6tPsPaKOOUK/DieZUidnSA8PHmcw6t26bV/R9KeeDlm
t/zDdrVzrFlo5G6EvF6DZyJv19Cszz0hcW+wYbIk4Lwm4qiBQpJ4WzP4nH7mg3P/
Dob5At+x/VlOhRoyQ2etqqPXpzq7duZPq8GrH/3n8fwD2afUy0BkbzmfNM/N5KIO
DnsrAHx0cvRstzFPhePF9LyFk2H+BJP+ikU+7SfN0+EaS9+32NljhxYH3MMm+FoG
ypBlJiaVCDmExF43TsOWSEuUsG6uCIy+dJK8FJPlV6pBSOekWE11ZCak/nevBCH4
LW9FRO4ShY+WUbxtD/MqRa1c/nm/k+htO72XwxBSGvgqiF30wFH+yJzkvvSe/73e
XPAKVVYJerzgg3Te5WqB3Pxo7hIqzQVzOVHk5kzmYUHRg6tRRuxsV2Pl05zMz/G3
3YPLfsCm/eqtUybMNYb2
=E/XF
-----END PGP SIGNATURE-----

--Apple-Mail=_91F22967-4FB3-488A-A40C-A44E504947BD--
