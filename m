Received: from eggs.gnu.org ([2001:4830:134:3::10]:42833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVIDe-0005SN-Dm
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVIDd-0004lZ-Ly
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:02:22 -0400
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
	<47cedaad-93e6-fc94-0bc2-278e2eea25e2@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <1901fce9-2e94-553d-f626-56fce97c7dba@msgid.tls.msk.ru>
Date: Wed, 12 Jul 2017 17:02:18 +0300
MIME-Version: 1.0
In-Reply-To: <47cedaad-93e6-fc94-0bc2-278e2eea25e2@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/13] Trivial patches for 2017-07-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

12.07.2017 16:57, Eric Blake wrote:

>> trivial patches for 2017-07-12
>>
>> ----------------------------------------------------------------
>> Eric Blake (2):
>>       qobject: Catch another straggler for use of qdict_put_str()
>>       qobject: Update coccinelle script to catch Q{INC, DEC}REF
> 
> You picked up v1 of these patches, when Markus was already planning on
> merging v2.  It may be easier to respin a v2 of the pull request that
> drops these patches from -trivial.

I haven't seen a v2, and the discussion for v1 seemed conclusive enough
and the patches looked okay too. But ok, I dropped these and resent.

Thanks,

/mjt
