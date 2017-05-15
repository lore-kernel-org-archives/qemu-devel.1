Received: from eggs.gnu.org ([2001:4830:134:3::10]:33415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAHDw-0002N6-R2
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAHDt-00051z-Nk
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:43:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dAHDt-000518-H6
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:43:45 -0400
References: <20170513022143.2838-1-n54@gmx.com>
	<20170515141348.GN1201@stefanha-x1.localdomain>
	<b299b025-720c-f2c0-1d63-8baf9b96d8b5@gmx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <296a3be1-ded2-2fd9-5ea2-86b1e786d5b7@redhat.com>
Date: Mon, 15 May 2017 16:43:41 +0200
MIME-Version: 1.0
In-Reply-To: <b299b025-720c-f2c0-1d63-8baf9b96d8b5@gmx.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] maintainers: Add myself as a NetBSD
 reviewer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org



On 15/05/2017 16:22, Kamil Rytarowski wrote:
> On 15.05.2017 16:13, Stefan Hajnoczi wrote:
>> On Sat, May 13, 2017 at 04:21:43AM +0200, Kamil Rytarowski wrote:
>>> I volunteer to review NetBSD patches.
>>> Adding myself will help to not miss some of them.
>>>
>>> Restore NetBSD as a maintained host.
>>>
>>> All patches to make qemu/pkgsrc building have been emitted to review.
>>>
>>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>>> ---
>>>  MAINTAINERS | 6 ++++++
>>>  configure   | 1 +
>>>  2 files changed, 7 insertions(+)
>>
>> Will you maintain a patch queue (git repo) so you can send pull
>> requests?  If yes, please add a T: field.
>>
>=20
> I don't think that there is a need for an additional patch queue, at
> least in the maintained mode as a volunteer in spare time.
>=20
> If there would be more BSD people, we could share a dedicated queue of
> patches.

How would patches be sent to the committer then?

Thanks,

Paolo
