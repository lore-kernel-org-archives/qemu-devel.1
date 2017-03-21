Received: from eggs.gnu.org ([2001:4830:134:3::10]:33027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqE4W-0004wm-SP
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqE4S-0007qu-BY
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:19:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqE4S-0007qG-5L
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:19:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490015515-25851-1-git-send-email-armbru@redhat.com>
	<1490015515-25851-6-git-send-email-armbru@redhat.com>
	<2030014641.9842228.1490016484915.JavaMail.zimbra@redhat.com>
Date: Tue, 21 Mar 2017 08:19:03 +0100
In-Reply-To: <2030014641.9842228.1490016484915.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 20 Mar 2017
	09:28:04 -0400 (EDT)")
Message-ID: <87o9wvt7vc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 5/6] tests/qapi-schema: Systematic
 positive doc comment tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Cc: marcandre lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Marc-Andr=C3=A9 Lureau <mlureau@redhat.com> writes:

> ----- Original Message -----
>> We have a number of negative tests, but we don't have systematic
>> positive coverage.  Fix that.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> didn't test it,

Patchew did :)

>                 but I assume it passes make check, so:
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
