Received: from eggs.gnu.org ([2001:4830:134:3::10]:44130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ekAhc-0002S5-Et
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ekAhZ-0006Vb-Cf
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:35:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:39862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ekAhZ-0006VF-65
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:35:01 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ekAhX-0005Tb-7U
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 15:34:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5DA732E81BB
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 15:34:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Feb 2018 15:20:54 -0000
From: Jirislaby <1379688@bugs.launchpad.net>
Reply-To: Bug 1379688 <1379688@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141010081105.4873.97725.malonedeb@wampee.canonical.com>
	<151811835138.27260.6433487248804025567.malone@soybean.canonical.com>
Message-Id: <6cce8e9e-1900-6493-5aa7-be7f56960feb@gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1379688] Re: qemu's monitor and parallel
 create huge window
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 02/08/2018, 08:32 PM, Thomas Huth wrote:
> Triaging old bug tickets... can you still reproduce this issue with the
> latest version of QEMU? Or could we close this ticket nowadays?

The issue is long gone, feel free to close.


-- =

js

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1379688

Title:
  qemu's monitor and parallel create huge window

Status in QEMU:
  Incomplete

Bug description:
  I have qemu 2.1. When I try to switch to monitor or parallel0, I get
  window which is 30 *thousand* pixels in height. It is only gray with
  no content. This did not happen with previous versions of qemu.

  Kwin crashes because it cannot handle such a huge window.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1379688/+subscriptions
