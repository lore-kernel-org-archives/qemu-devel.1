Received: from eggs.gnu.org ([2001:4830:134:3::10]:39517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkwtJ-0004VW-JU
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkwtE-000050-NC
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:30:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkwtE-0008Vp-H2
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:30:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
	<1503564371-26090-2-git-send-email-armbru@redhat.com>
	<09db4afe-7fa3-97fc-9eef-a58b4d453193@redhat.com>
Date: Thu, 24 Aug 2017 20:29:55 +0200
In-Reply-To: <09db4afe-7fa3-97fc-9eef-a58b4d453193@redhat.com> (Eric Blake's
	message of "Thu, 24 Aug 2017 11:32:29 -0500")
Message-ID: <874lswes4c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/16] qapi: Update qapi-code-gen.txt
 examples to match current code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/24/2017 03:45 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  docs/devel/qapi-code-gen.txt | 47 +++++++++++++++++++++++++++++++++++--=
-------
>>  1 file changed, 38 insertions(+), 9 deletions(-)
>
> Might be nice to call out which commit(s) failed to update the docs when
> they tweaked the generated output.

I commonly do that for code, because knowing when something broke can be
useful.  I feel it's less useful for these examples.

Marc-Andr=C3=A9 finds them "tedious and not really useful" in general.  If
everybody feels like that, we can delete them.
