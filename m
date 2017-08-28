Received: from eggs.gnu.org ([2001:4830:134:3::10]:58561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmIEM-0007jw-US
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmIEK-0005Yz-5J
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:29:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dmIEJ-0005Ya-Vl
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:29:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
	<1503602048-12268-12-git-send-email-armbru@redhat.com>
	<CAJ+F1C+JyRBxc-cv0ko1zqNnNt6N0h5OhrLM2GdVT3yLocgNKw@mail.gmail.com>
Date: Mon, 28 Aug 2017 13:29:17 +0200
In-Reply-To: <CAJ+F1C+JyRBxc-cv0ko1zqNnNt6N0h5OhrLM2GdVT3yLocgNKw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 25 Aug 2017
	11:20:11 +0000")
Message-ID: <87inh82anm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/16] qapi-schema: Collect TPM stuff in
 qapi/tpm.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Thu, Aug 24, 2017 at 9:23 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> Sadly, we don't have a TPM maintainer, not even a MAINTAINERS entry.
>> Create one, and mark it orphaned.
>>
>>
> This is also proposed in:
> http://patchew.org/QEMU/20170728053610.15770-1-f4bug@amsat.org/

Forgot about that one.

My patch additionally has "F: include/hw/acpi/tpm.h", and of course the
new "qapi/tpm.json", and it's not marked "RFC".

> Stefan Berger, any chance you declare yourself a TPM maintainer?

Please?

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
