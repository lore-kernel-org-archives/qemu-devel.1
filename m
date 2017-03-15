Received: from eggs.gnu.org ([2001:4830:134:3::10]:44614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co35f-0006Mx-Ed
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co35c-00015m-87
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:11:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co35c-00015d-1n
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:11:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-9-git-send-email-armbru@redhat.com>
	<b2ec8f48-eda6-0511-37c4-7c11e3a2e7fd@redhat.com>
Date: Wed, 15 Mar 2017 08:11:17 +0100
In-Reply-To: <b2ec8f48-eda6-0511-37c4-7c11e3a2e7fd@redhat.com> (Eric Blake's
	message of "Tue, 14 Mar 2017 10:56:38 -0500")
Message-ID: <87zignrp4a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 08/47] tests/qapi-schema: Cover
 empty union base
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

> On 03/13/2017 01:18 AM, Markus Armbruster wrote:
>> The new test case shows off qapi.py choking on an empty union base.
>
> We're still finding ways to choke the parser ;)

At least we're not finding dozens of ways without having to look hard
anymore :)

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
