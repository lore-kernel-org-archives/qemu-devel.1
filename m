Received: from eggs.gnu.org ([2001:4830:134:3::10]:60587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fNEUf-0004II-45
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fNEUb-0006ui-4H
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:31:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51740 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fNEUb-0006uV-0W
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:31:05 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502467522-32237-1-git-send-email-armbru@redhat.com>
	<20180416161753.GA12819@redhat.com>
Date: Mon, 28 May 2018 11:31:03 +0200
In-Reply-To: <20180416161753.GA12819@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Mon, 16 Apr 2018 17:17:53 +0100")
Message-ID: <87r2lwnn3c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] vl: Partial support for non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: kwolf@redhat.com, el13635@mail.ntua.gr, f4bug@amsat.org, qemu-devel@nongnu.org, pbonzini@redhat.com

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Just a ping to say I'd like us to restart work this patch and try to get
> it mergable for the 2.13 cycle, so I can rely it on for the ACL support
> I've had out of tree since 2.6 :-)

Fair enough.  I'll see what I can do.
