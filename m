Received: from eggs.gnu.org ([2001:4830:134:3::10]:36765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <njh@bandsman.co.uk>) id 1dVeNZ-00048e-MQ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <njh@bandsman.co.uk>) id 1dVeNV-0002gI-RM
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:42:05 -0400
Received: from nihsmtpxway5.hub.nih.gov ([128.231.90.97]:32818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <njh@bandsman.co.uk>) id 1dVeNV-0002eY-Ky
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:42:01 -0400
From: Nigel Horne <njh@bandsman.co.uk>
References: <f1a9dc49-40d8-828b-26fa-76261ee95fab@bandsman.co.uk>
	<CAFEAcA-8qNiyD3yfBS3EBq6rdB8oUcc7B9qeGp5KBQs7SggmAA@mail.gmail.com>
	<be531cc1-50d4-4149-7499-ac8fe554bd23@bandsman.co.uk>
	<ff9234b1-1d33-dc38-8e62-846914f7d0ea@amsat.org>
	<3e488f92-ecff-9d94-84de-de9523c2361c@bandsman.co.uk>
Message-ID: <52e480e3-14a4-b9f7-65fc-39144d0cba3f@bandsman.co.uk>
Date: Thu, 13 Jul 2017 09:41:59 -0400
MIME-Version: 1.0
In-Reply-To: <3e488f92-ecff-9d94-84de-de9523c2361c@bandsman.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Link error with github source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 7/13/17 9:34 AM, Nigel Horne wrote:
> I'm going to explicitly add '-cc=gcc-7' and see if that helps.

That fixed it.  Sorry for the noise.

-Nigel

-- 
Nigel Horne
Conductor: Rockville Brass Band, Washington Metropolitan GSO
@nigelhorne | fb/nigel.horne | bandsman.co.uk | concert-bands.co.uk | www.nigelhorne.com

Unless it's for my eyes only, please use "reply all"
