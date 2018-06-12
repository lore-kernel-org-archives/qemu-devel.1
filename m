Received: from eggs.gnu.org ([2001:4830:134:3::10]:39837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSi9b-00083K-JH
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSi9X-0000lM-KA
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:12:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40092 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fSi9X-0000kk-EZ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:11:59 -0400
References: <20180612065150.21110-1-ville.skytta@iki.fi>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d26962f9-7f7d-da39-861e-0e5b5515c703@redhat.com>
Date: Tue, 12 Jun 2018 07:11:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180612065150.21110-1-ville.skytta@iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: Grammar and spelling fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Ville_Skytt=c3=a4?= <ville.skytta@iki.fi>, qemu-devel@nongnu.org

On 06/12/2018 01:51 AM, Ville Skytt=C3=A4 wrote:
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---

It's helpful to use 'git send-email -v3' (or 'git format-patch -v3',=20
depending on your workflow) so that the subject line tags this as a=20
third spin of the same patch previously posted, and to include, after=20
the --- separator, how it differs from v2 (in this case, incorporating=20
my review comment to reflow a long line).  Otherwise, automated tools=20
might not pick up on the fact that this email replaces your earlier=20
submission as the one to test.  Other submission tips can be found at:

https://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
