Received: from eggs.gnu.org ([2001:4830:134:3::10]:48178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dcFAM-0000Or-DX
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dcFAH-0005Cl-GU
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:11:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dcFAH-0005AE-AD
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:11:37 -0400
References: <374E3394-46D9-4459-AE2E-059F8EEC7406@gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c76ef5de-81a5-a98e-d598-161694248788@redhat.com>
Date: Mon, 31 Jul 2017 14:03:17 -0400
MIME-Version: 1.0
In-Reply-To: <374E3394-46D9-4459-AE2E-059F8EEC7406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Call for testers for various versions of Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>



On 07/28/2017 03:45 PM, Programmingkid wrote:
> I have made a page that keeps track of anyone who wishes to be a tester for a particular version of Windows. Here is the page: http://wiki.qemu.org/Testing/Windows
> 

I think for this to be successful, you'd have to define exactly what the
required testing *is*.

Are these simple installation smoketests? Installation and boot? How big
is the test matrix? What is considered a pass and what is not? Across
which machine types and which architectures?

etc.

> If there is a version of Window you would like to help test in QEMU, please contact me with the email address you wish to use and the version of Windows you wish to support. Your information will be added to this list. With this list someone who makes a patch may need your help ensuring the patch is compatible with your supported version of Windows. 
> 
> Here are all the versions of Windows I have up so far:
> 
> Windows 3.1
> Windows NT 3.1
> Windows NT 3.5
> Windows 95
> Windows NT 4.0
> Windows 98
> Windows ME
> Windows 2000
> Windows XP
> Windows Vista
> Windows 7
> Windows 8
> Windows 10
> ReactOS
> 

There's probably people willing to at least do boot tests for some of
these, but I doubt there's much interest in doing anything more rigorous
than that.
