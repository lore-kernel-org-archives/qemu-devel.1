Received: from eggs.gnu.org ([2001:4830:134:3::10]:38929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cipPv-0005pj-MN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cipPs-0003DZ-Jp
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:34:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cipPs-0003DI-E5
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:34:40 -0500
References: <1488272804-27144-1-git-send-email-kraxel@redhat.com>
	<658a0501-0696-b9d9-2cfd-169277a85c1a@redhat.com>
	<1488306274.26614.41.camel@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4a4764c2-1af5-394a-08d2-6a08a690374a@redhat.com>
Date: Tue, 28 Feb 2017 16:34:39 -0500
MIME-Version: 1.0
In-Reply-To: <1488306274.26614.41.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/1] seabios: update to 1.10.2 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>



On 02/28/2017 01:24 PM, Gerd Hoffmann wrote:
> On Di, 2017-02-28 at 11:48 -0500, John Snow wrote:
>>
>> On 02/28/2017 04:06 AM, Gerd Hoffmann wrote:
>>>   Hi,
>>>
>>> Here comes the seabios update for qemu 2.9,
>>> the just tagged 1.10.2 release.
>>>
>>> Our seabios.git mirror @ qemu.org seems to not sync properly.  The
>>> commit isn't there even though it was pushed a few days ago already
>>> (only the tag was pushed today).  John, can you have a look please?
>>> master branch, *-stable branches and all tags should be mirrored.
>>>
>>
>> http://git.qemu-project.org/?p=seabios.git;a=log
>>
>> Looks like the patch I wanted to be there is in there. Are you
>> referencing Ladi's commit? It looks like it's there just fine.
> 
> Commits from February are missing.  And this one ...
> 
> http://git.qemu-project.org/?p=seabios.git;a=shortlog;h=refs/heads/1.10-stable
> 
> ... is outdated too.
> 
> cheers,
>   Gerd
> 

Oh, uhm... Who maintains the mirror? Jeff Cody is on vacation.

CCing Peter.

--js
