Received: from eggs.gnu.org ([2001:4830:134:3::10]:60989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqE3u-0004eR-QF
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqE3p-0007Pd-UD
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:18:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqE3p-0007P7-PF
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:18:29 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490015515-25851-1-git-send-email-armbru@redhat.com>
	<1490015515-25851-5-git-send-email-armbru@redhat.com>
	<1268717042.9839783.1490016440609.JavaMail.zimbra@redhat.com>
Date: Tue, 21 Mar 2017 08:18:25 +0100
In-Reply-To: <1268717042.9839783.1490016440609.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 20 Mar 2017
	09:27:20 -0400 (EDT)")
Message-ID: <87shm7t7we.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/6] tests/qapi-schema: Make
 test-qapi.py print docs again
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
>> test-qapi.py used to print the internal representation of doc comments
>> (commit 3313b61).  This went away when we dropped the doc comments in
>> positive tests (commit 87c16dc).  Bring it back, because I'm going to
>> add real positive doc comment tests.
>
> Yup, as I pointed out in the previous series, but since you biring it bac=
k modified:

As you see, I took your complaint about the loss of positive tests
seriously :)

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
